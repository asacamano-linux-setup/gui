# i3 tiling window manager
i3:
  pkg:
    - installed

# rofi app launche
rofi:
  pkg:
    - installed

gnome-term-profile:
  cmd.run:
    - name: "dconf load /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/ < gnome-terminal-profile"
    - cwd: "{{ grains['sync_dir'] }}/modules/gui/"
    - unless: "[[ -z ${DISPLAY} ]]"
    - runas: {{ grains['target_user'] }}

# Set up the config file
"{{ grains['target_home'] }}/.config":
  file.directory:
    - user: {{ grains['target_user'] }}
    - group: {{ grains['target_user'] }}
    - dir_mode: 755
    - makedirs: true

i3_conf_general:
  file.managed:
    - name: "{{ grains['target_home'] }}/.config/i3"
    - source: "salt://i3"
    - group:  {{ grains['target_user'] }}
    - mode: 644
    - template: jinja

gui_i3_conf:
  file.accumulated:
    - name: i3_includes
    - filename: "{{ grains['target_home'] }}/.config/i3"
    - text: "# Placeholder for other modules i3 chnages"
    - require_in:
      - file: i3_conf_general

