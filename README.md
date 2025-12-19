# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Model (Todo)

Migration

Controller (manual)

Routes

Views (manual)

CRUD flows

Perfect — now you’re asking the **right enterprise-level question** 
Forget Todo as a *toy*. Let’s treat it as a **pattern** you will reuse for **any real application feature**.

I’ll explain this **as a repeatable recipe** you can apply to **any “simple functionality”** in an enterprise Rails app.

I’ll use a **generic example** instead of Todo so you can generalize it.

---

#  The Enterprise Rails Pattern (End-to-End)

> Any feature in Rails = **Data + Flow + Presentation**

No matter how big the app is, every feature still goes through the **same 6 layers**.

---

##  Example Feature (Generic, Enterprise-style)

Let’s say your enterprise app needs this feature:

> **“Employees can submit a Leave Request, and managers can view them.”**

This is *not* a toy — this is real enterprise functionality.

Now we’ll implement it end-to-end using:

* Model
* Migration
* Controller
* Routes
* Views
* CRUD flow

---

# 1 Migration — *Define the data structure*

### Question this layer answers

> “What data do I need to store permanently?”

### You think in **tables & columns**, not Ruby yet.

```bash
rails generate migration CreateLeaveRequests
```
rails db:migrate
```ruby
class CreateLeaveRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :leave_requests do |t|
      t.string  :employee_name
      t.date    :start_date
      t.date    :end_date
      t.string  :status, default: "pending"

      t.timestamps
    end
  end
end
```

Run:

```bash
rails db:migrate
```

**Enterprise rule**
Migrations describe **structure**, not behavior.

---

# 2 Model — *Define rules & meaning of the data*

### Question this layer answers

> “What makes this data valid and meaningful?”

```ruby
class LeaveRequest < ApplicationRecord
  validates :employee_name, :start_date, :end_date, presence: true

  def duration
    (end_date - start_date).to_i + 1
  end
end
```

### What belongs here

 Validations
 Business logic
 Domain rules
 Query helpers

 HTTP logic
 UI logic

**Enterprise rule**
Models should be reusable by:

* controllers
* background jobs
* services
* APIs

---

# 3 Routes — *Expose functionality to the outside world*

### Question this layer answers

> “How does the outside world access this feature?”

```ruby
Rails.application.routes.draw do
  get  "/leave_requests",     to: "leave_requests#index"
  get  "/leave_requests/new", to: "leave_requests#new"
  post "/leave_requests",     to: "leave_requests#create"
end
```

Routes are:

* explicit
* predictable
* easy to audit

**Enterprise rule**
Routes should read like **API documentation**.

---

# 4 Controller — *Orchestrate the request*

### Question this layer answers

> “What happens when a request comes in?”

```ruby
class LeaveRequestsController < ApplicationController
  def index
    @leave_requests = LeaveRequest.all
  end

  def new
    @leave_request = LeaveRequest.new
  end

  def create
    @leave_request = LeaveRequest.new(leave_request_params)

    if @leave_request.save
      redirect_to leave_requests_path
    else
      render :new
    end
  end

  private

  def leave_request_params
    params.require(:leave_request)
          .permit(:employee_name, :start_date, :end_date)
  end
end
```

### What belongs here

 Calling models
 Handling success/failure
 Choosing views or redirects

 Business rules
 SQL logic

**Enterprise rule**
Controllers should feel **boring** — that’s good.

---

# 5 Views — *Present the data*

### Question this layer answers

> “How should this look to the user?”

---

### `index.html.erb`

```erb
<h1>Leave Requests</h1>

<ul>
  <% @leave_requests.each do |lr| %>
    <li>
      <%= lr.employee_name %> |
      <%= lr.start_date %> → <%= lr.end_date %> |
      Status: <%= lr.status %>
    </li>
  <% end %>
</ul>

<a href="/leave_requests/new">Request Leave</a>
```

---

### `new.html.erb`

```erb
<h1>New Leave Request</h1>

<form action="/leave_requests" method="post">
  <%= csrf_meta_tags %>

  <input name="leave_request[employee_name]" />
  <input type="date" name="leave_request[start_date]" />
  <input type="date" name="leave_request[end_date]" />

  <button type="submit">Submit</button>
</form>
```

**Enterprise rule**
Views only **display** data — they never decide behavior.

---

# 6 CRUD Flow — *How everything connects*

CRUD is **not code**, it’s a **mental flow**.

---

##  CREATE Flow (Enterprise view)

1. User submits form
2. Route maps to controller
3. Controller builds model
4. Model validates rules
5. DB persists data
6. Controller redirects or re-renders
7. View shows updated state

Every enterprise feature follows this pattern.

---

##  Universal Rails Feature Template (Memorize this)

When adding **any new feature**, ask these questions **in order**:

1 What data do I need? → **Migration**
2 What rules apply? → **Model**
3 How is it accessed? → **Routes**
4 How is it handled? → **Controller**
5 How is it shown? → **Views**
6 How does it flow? → **CRUD flow**

This works for:

* HR systems
* Finance systems
* Admin panels
* AI workflows
* APIs

---

##  Final Enterprise Insight

> **Rails is not about Todo apps.
> Todo apps are just the smallest example of enterprise patterns.**

Once you understand the **pattern**, the domain doesn’t matter.

---

app/
├── controllers/
│   ├── workspaces_controller.rb
│   ├── documents_controller.rb
│   └── questions_controller.rb
│
├── models/
│   ├── workspace.rb
│   ├── document.rb
│   ├── chunk.rb
│   └── message.rb
│
├── jobs/
│   ├── document_ingest_job.rb
│   └── agent_reasoning_job.rb
│
├── services/
│   ├── ollama/
│   │   ├── client.rb
│   │   └── embeddings.rb
│   ├── agent/
│   │   ├── runner.rb
│   │   └── toolbox.rb
│   └── chunker.rb
│
├── views/
│   └── workspaces/
│
└── channels/
    └── agent_channel.rb
