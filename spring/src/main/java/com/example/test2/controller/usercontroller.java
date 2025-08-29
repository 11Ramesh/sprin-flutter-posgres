package com.example.test2.controller;

import com.example.test2.dto.UserDTO;
import com.example.test2.model.User;
import com.example.test2.repo.UserRepo;
import com.example.test2.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.oauth2.resource.OAuth2ResourceServerProperties;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import com.example.test2.security.JwtUtil;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@CrossOrigin
@RequestMapping(value = "/api/v1/")
public class usercontroller {
    @Autowired
    private UserService userservice;

    @GetMapping(value = "/getuser")
    public List<UserDTO> getuser() {
        return userservice.getalluser();
    }

    @Autowired
    private PasswordEncoder passwordEncoder;



    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserRepo userRepo;


    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(
            @RequestParam String username,
            @RequestParam String password) {

        User user = userRepo.findByUsername(username)
                .orElse(null);

        Map<String, String> response = new HashMap<>();

        if (user == null) {
            response.put("message", "User not found");
            return ResponseEntity.status(404).body(response); // 404 Not Found
        }

        if (!passwordEncoder.matches(password, user.getPassword())) {
            response.put("message", "Invalid password");
            return ResponseEntity.status(401).body(response); // 401 Unauthorized
        }

        // Generate tokens
        String accessToken = jwtUtil.generateAccessToken(username);
        String refreshToken = jwtUtil.generateRefreshToken(username);

        response.put("accessToken", accessToken);
        response.put("refreshToken", refreshToken);
        response.put("message", "Login successful");

        return ResponseEntity.status(200).body(response); // 200 OK
    }

    @PostMapping("/register")
    public ResponseEntity<Map<String, String>> register(
            @RequestParam String username,
            @RequestParam String password) {

        Map<String, String> response = new HashMap<>();

        //check if null username or password
        if (username.isEmpty() || password.isEmpty()){
            response.put("message", "Username or Password Empty");
            return ResponseEntity.status(400).body(response);
        }

        // Check if username already exists
        if (userRepo.findByUsername(username).isPresent()) {
            response.put("message", "Username already taken");
            return ResponseEntity.status(409).body(response); // 409 Conflict
        }

        // Create new user
        User newUser = new User();
        newUser.setUsername(username);

        // Hash the password
        String hashedPassword = passwordEncoder.encode(password);
        newUser.setPassword(hashedPassword);

        // Save user
        userRepo.save(newUser);

        // Generate tokens immediately after registration
        String accessToken = jwtUtil.generateAccessToken(username);
        String refreshToken = jwtUtil.generateRefreshToken(username);

        response.put("accessToken", accessToken);
        response.put("refreshToken", refreshToken);
        response.put("message", "User registered successfully");

        return ResponseEntity.status(201).body(response); // 201 Created
    }

//use for bellow code for test cases.crud operation

//    @PostMapping(value = "/saveuser")
//    public UserDTO saveuser(@RequestBody UserDTO userdto){
//        return userservice.saveuser(userdto);
//    }
//
//
//    @PutMapping(value = "/updateuser")
//    public UserDTO updateuser(@RequestBody UserDTO userdto){
//        return userservice.updateuser(userdto);
//    }
//
//    @DeleteMapping(value = "/deleteuser/{userid}")
//    public String deleteuser(@PathVariable int userid){
//        return userservice.deleteuser(userid);
//    }

}

