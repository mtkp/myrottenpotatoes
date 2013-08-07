OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(
  :twitter,
  { uid: '12345', info: { name: "Senor Test" }
})