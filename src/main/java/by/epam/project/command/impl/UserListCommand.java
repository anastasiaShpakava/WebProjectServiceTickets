package by.epam.project.command.impl;

import by.epam.project.command.Command;
import by.epam.project.command.PathForJsp;
import by.epam.project.entity.User;
import by.epam.project.exception.ServiceException;
import by.epam.project.service.UserService;
import by.epam.project.service.impl.UserServiceImpl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Этот класс используется что бы показать весь список пользователей администратору
 *
 * @author Shpakova A.
 */

public class UserListCommand implements Command {
    private static final int NUMBER_USERS_PER_PAGE = 8;
    private static final String USERS_PER_PAGE = "usersPerPage";
    private static final String INDEX_OF_PAGE = "indexOfPage";
    private static final String USER_LIST_COMMAND = "user_list";
    private static final String COMMAND_VALUE = "commandValue";
    private static final String USER_LIST_SIZE = "userListSize";
    private static final String USER_LIST = "userList";
    private static final String GREATER_THAN_ONE_ADMIN = "greaterThanOneAdmin";

    @Override
    public String execute(HttpServletRequest request,HttpServletResponse response) {

        int indexOfPage;
        if (request.getParameter(INDEX_OF_PAGE) != null) {
            indexOfPage = Integer.parseInt(request.getParameter(INDEX_OF_PAGE));
        } else {
            indexOfPage = 1;
        }

        UserService userService = new UserServiceImpl();
try{
        List<User> userList = userService.takeAllUsersWithLimit(
                (indexOfPage - 1) * NUMBER_USERS_PER_PAGE,
                indexOfPage * NUMBER_USERS_PER_PAGE);

        if (userList.stream()
                .filter(user -> user.getUserRole().name().equals("ADMINISTRATOR"))
                .count() > 1) {
            request.setAttribute(GREATER_THAN_ONE_ADMIN, true);
        } else {
            request.setAttribute(GREATER_THAN_ONE_ADMIN, false);
        }

        request.setAttribute(USER_LIST, userList);

        request.setAttribute(INDEX_OF_PAGE, indexOfPage);
        request.setAttribute(USER_LIST_SIZE, userService.takeAllUsers().size());
        request.setAttribute(COMMAND_VALUE, USER_LIST_COMMAND);
        request.setAttribute(USERS_PER_PAGE, NUMBER_USERS_PER_PAGE);
} catch (ServiceException e) {
    e.printStackTrace();
}
        return PathForJsp.USER_LIST.getUrl();
    }
}
