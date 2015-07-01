Template1 = ->
  template: '
		<h3>DCS Undergraduate Project Portal</h3>
		<hr>

		<p>
			The DCS Undergraduate Project Portal is a Student-Research Project matching
			program developed by students from the Department of Computer Science at the University
			of Toronto.
		</p>

		<p>
			DCSUPP allows students to view and apply to projects. It also allows researchers and
			professors to post projects. DCSUPP also includes project applications and project to
			student matching. Our site reuses application information as much as possible to user
			experience.
		</p>

		<p>
			Contact alan[dot]yuan@mail[dot]utoronto[dot].ca for more information
		</p>
		<hr>

		<button class="btn btn-default" type="submit" ng-click="flippage()">
			For Academics, Researchers and Graduate Students <span aria-hidden="true"> &rarr;</span>
		</button>
	'

Template2 = ->
  template: '
		<h3>Acacdemics, Researchers and Graduate Students</h3>
		<hr>

		<p>Page 2</p>

		<hr>
		<button class="btn btn-default" type="submit" ng-click="flippage()">
			For Students <span aria-hidden="true"> &rarr;</span>
		</button>
	'

Template3 = ->
  template: '
		<h3>Students</h3>
		<hr>

		<p>Page 3</p>

		<hr>
		<button class="btn btn-default" type="submit" ng-click="flippage()">
			DCSUPP Development Team <span aria-hidden="true"> &rarr;</span>
		</button>
	'

Template4 = ->
  template: '
		<h3>DCSUPP Development Team</h3>
		<hr>

		<p>DCSUPP is developed by students at the Department of Computer Science. </p>

		<hr>
		<button class="btn btn-default" type="submit" ng-click="flippage()">
			Introduction <span aria-hidden="true"> &rarr;</span>
		</button>
	'


angular
.module("dcsupp")
.directive("intropage1", Template1)
.directive("intropage2", Template2)
.directive("intropage3", Template3)
.directive("intropage4", Template4)