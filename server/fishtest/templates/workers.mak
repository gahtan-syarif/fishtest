<%inherit file="base.mak"/>

<%!
  import datetime
  from fishtest.util import delta_date, diff_date
%>

<script>
  document.title = 'Workers Management | Stockfish Testing';
</script>

<h2>Workers Management</h2>

% if show_admin:
  <h3>${worker_name}</h3>
  <form method="POST">
    <div class="mb-3">Last changed: ${delta_date(diff_date(last_updated)) if last_updated is not None else "Never"}</div>
    <div class="mb-3">
      <label for="messageInput" class="form-label">Message</label>
      <textarea id="messageInput" rows="4" class="form-control" placeholder="Leave a comment here" name="message">${message}</textarea>
    </div>
    <div class="mb-3 form-check">
      <label class="form-check-label" for="blockWorker">Blocked</label>
      <input type="checkbox" class="form-check-input" id="blockWorker" name="blocked" ${"checked" if blocked else ""}>
    </div>
    <button type="submit" name="submit" value="Submit" class="btn btn-primary">Submit</button>
    <button type="submit" name="sumbit" class="btn btn-secondary">Cancel</button>
  </form>
  <hr>
% endif  ## show_admin

<h3>Blocked workers</h3>
<table class="table table-striped table-sm">
  <thead class="sticky-top">
    <tr>
      <th>Worker</th>
      <th>Last changed</th>
      <th>Events</th>
    </tr>
  </thead>
  <tbody>
    % if len(blocked_workers) == 0:
      <tr>
        <td colspan="3">No blocked workers</td>
      </tr>
    % else:
      % for w in blocked_workers:
        <tr>
          <td><a href="/workers/${w['worker_name']}">${w["worker_name"]}</td>
          <td>${delta_date(diff_date(w["last_updated"])) if last_updated is not None else "Never"}</td>
          <td><a href="/actions?text=%22${w['worker_name']}%22">/actions?text="${w['worker_name']}"</a></td>
        </tr>
      % endfor
    % endif
  </tbody>
</table>
