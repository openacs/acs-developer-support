<if @show_p@ true>
  <if @comments:rowcount@ gt 0>
    <div id="developer-support-footer">
      <multiple name="comments">
        <b>Comment:</b> @comments.text@<br />
      </multiple>
    </div>
  </if>
  <if @user_switching_p@ true>
    <form action="@set_user_url@">
      @export_vars;noquote@
      <div id="developer-support-footer">
        Real user: @real_user_name@ (@real_user_email@) [user_id #@real_user_id@]<br />
        <if @real_user_id@ ne @fake_user_id@>      
          Faked user: @fake_user_name@ (@fake_user_email@) [user_id #@fake_user_id@]<br />
        </if>
        <else>
          Faked user: <i>Not faking.</i><br />
        </else>
        Change faked user: <select name="user_id">
          <multiple name="users">
            <option value="@users.user_id@" <if @users.selected_p@>selected</if>>@users.name@ <if @users.email@ not nil>(@users.email@)</if></option>
          </multiple>
        </select>
        <input type="submit" value="Go">
      </div>
    </form>
  </if>
</if>