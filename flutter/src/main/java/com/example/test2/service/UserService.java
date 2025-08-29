package com.example.test2.service;

import com.example.test2.dto.UserDTO;
import com.example.test2.model.User;
import com.example.test2.repo.UserRepo;
import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


// use test cases olnly. Crud operation do usig this

import java.util.List;

@Service
@Transactional

public class UserService {
    @Autowired
    private UserRepo userrepo;

    @Autowired
    private ModelMapper modelMapper;


    public List<UserDTO> getalluser() {
        List<User> userList = userrepo.findAll();
        return modelMapper.map(userList, new TypeToken<List<UserDTO>>(){}.getType());
    }



    public UserDTO saveuser(UserDTO userdto) {

        User userEntity = modelMapper.map(userdto, User.class);

        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String hashedPassword = passwordEncoder.encode(userEntity.getPassword());
        userEntity.setPassword(hashedPassword);
        userrepo.save(userEntity);

        return userdto;
    }



    public UserDTO updateuser(UserDTO userdto){
        userrepo.save(modelMapper.map(userdto, User.class));
        return userdto;
    }

    public String deleteuser(int userid){
        userrepo.deleteById(userid);
        return "Deleted";
    }
}
