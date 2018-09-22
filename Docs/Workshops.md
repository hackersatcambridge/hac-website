The website reads information about workshops from separate workshop repositories. 

- It first reads the [workshops](https://github.com/hackersatcambridge/workshops) repository to find out which workshops exist (see WorkshopManager.swift)
- Then it finds the repositories for each of those workshops (by prepending "workshop-" to the workshop name)
- The content of these repositories is parsed into a Workshop model (see Workshop+init.swift)

For instructions for creating a new workshop repository, see the [template workshop](https://github.com/hackersatcambridge/workshop-template) repository.
