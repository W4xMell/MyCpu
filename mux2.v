module mux2 #(parameter WIDTH = 8) (
    input  wire[WIDTH-1:0] a, b,
    input  wire ctrl,
    output wire[WIDTH-1:0] res
);
    assign res = ctrl ? b : a;
endmodule