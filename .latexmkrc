
# ===============================
# Latexmk config (XeLaTeX + Biber + Minted)
# ===============================

# Engine: dùng XeLaTeX với minted (bắt buộc -shell-escape)
$pdflatex = 'xelatex -shell-escape -interaction=nonstopmode -synctex=1 %O %S';

# Chạy XeLaTeX nhiều lần nếu cần (default latexmk sẽ xử lý)
$latex = $pdflatex;

# Dùng Biber thay cho BibTeX
$biber = 'biber %O %B';

# Viewer PDF (đồng bộ tốt với Zathura, Sumatra, Evince,…)
$pdf_previewer = 'zathura %S';

# Giữ file log để debug
$recorder = 1;

# Mặc định latexmk dọn file tạm sau khi build thành công
# Nếu muốn giữ lại để debug, comment dòng dưới
$cleanup_includes_cusdep_generated = 1;

# Danh sách các file phụ sẽ được xóa khi 'latexmk -c'
@generated_exts = qw(aux bbl bcf blg fdb_latexmk fls log out run.xml toc lof lot lol synctex.gz);

# Khi có lỗi thì vẫn tạo PDF (nếu có thể)
$pdf_mode = 1;  # 1 = PDF via pdflatex/xelatex
$force_mode = 1;

# Bật chế độ tự động build khi file thay đổi (khi gọi latexmk -pvc)
$pvc_view_file_via_temporary = 0;
