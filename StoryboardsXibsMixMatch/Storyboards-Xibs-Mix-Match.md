# Storyboards & Xibs mix & match

## Open the initial VC of a storyboard from another storyboard using IB (no code)

- create a second Storyboard
- add a VC to that second storyboard
- mark as Initial View Controller (Inside Attributes Inspector > Is initial View Controller)
- in the first storyboard add a Storyboard Reference
- select in the Storyboard Reference Second Storyboard
- leave Referenced ID (defaults to Initial View Controller)
- connect a button to the Storyboard Reference to create a Segue
- this open the initial View Controller

---

## Open any VC of a storyboard from another storyboard using IB (no code)

- create a second Storyboard
- add a VC to that second storyboard
- Add a storyboard identifier, it's just a String (Inside Identity Inspector > Storyboard ID)
- in the first storyboard add a Storyboard Reference
- select in the Storyboard Reference Second Storyboard
- leave Referenced ID (defaults to Initial View Controller)
- connect a button to the Storyboard Reference to create a Segue
- this open the initial View Controller

---