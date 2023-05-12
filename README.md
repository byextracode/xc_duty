# xc_duty

## Description
Provides exports function for esx job duty handle. 

## Feature
- setDuty exports, toggle job duty (e.g. police/offpolice).
- isAuthorized exports, check current job for passed jobs.
- isDuty exports, (returns true if current job equals configured onduty job, false if current job equals configured offduty job)
- isAuthorized server exports, similar like isAuthorized client exports.
- Configuration for job duty location.

## Preview
- [Preview 1](https://streamable.com/xcibt4) (using ox_target)
- [Preview 2](https://streamable.com/0vujq9)

## Framework
- ESX

## Requirement
- ESX
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target) (optional)

# Legal

xc_duty

Copyright (C) 2023 [wobozkyng](https://github.com/wobozkyng)

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.