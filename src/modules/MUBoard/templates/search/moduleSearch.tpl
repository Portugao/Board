{include file='user/header.tpl'}
<h2>{gt text ='Look for relevant issues!'}</h2>
<form class="z-form" action="" method="post">
<fieldset>
<div class="z-formrow">
<label for="searchstring">{gt text='Search Terms'}</label>
<input id="searchstring" name="searchstring" type="text">
</div>
<div class="z-formrow">
<label for="searchoptions">{gt text='Search options'}</label>
<select id="searchoptions">
<option value="all">{gt text='All terms [AND]'}</option>
<option value="single">{gt text='Single terms [OR]'}</option>
<option value="correct">{gt text='Correct term'}</option>
</select>
</div>
<div class="z-formrow">
<label for="searchplace">{gt text='Search place'}</label>
<select id="searchplace">
<option value="title">{gt text='Only in titles'}</option>
<option value="content">{gt text='In titles and content'}</option>
</select>
</div>
<div class="z-formrow">
<label for="resultorder">{gt text='Order of results'}</label>
<select id="resulorder">
<option value="Asc">{gt text='Ascending'}</option>
<option value="Desc">{gt text='Descending'}</option>
</select>
</div>
<div class="z-formbuttons">
<input id="searchsubmit" name="searchsubmit" type="submit" value="{gt text='Search'}">
</div>
</fieldset>

</form>
