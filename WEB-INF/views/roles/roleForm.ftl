<div class="roleForm">
	<@s.form action="saveRole">
		<@s.hidden name="id"/>
		<@s.textfield label="Name" name="currentRole.name"/>		
		<@s.submit value="Save"/>
	</@s.form>
</div>