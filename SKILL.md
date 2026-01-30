---
name: logi-optimizer
description: Helps users remove bloated Logitech official applications (G HUB, Logi Options+), clean up residual files, and then install the lightweight Logi Options+ Mini tool. Suitable when users complain about Logitech software consuming resources or want a cleaner system.
---

# Logitech Optimization Skill

This Skill is designed to help users safely remove official Logitech software and migrate to a lightweight alternative.

## Step 1: Clean Up Official Software (Purge)

Before executing any deletion operations, always perform a dry run first and obtain user consent.

1.  **Dry Run**:
    Execute the cleanup script and display items to be deleted:
    ```bash
    ./scripts/official-logi-pruge.sh --dry-run
    ```

2.  **Confirm and Execute**:
    Display the above output to the user and ask: "Do you agree to execute the above cleanup operation? (This will remove all Logitech official drivers and software)"
    If the user agrees, execute:
    ```bash
    ./scripts/official-logi-pruge.sh
    ```
    *Note: This process may require the user to enter a password (sudo).*

## Step 2: Install Logi Options+ Mini (Install)

After cleanup is complete, assist with installing the community-maintained lightweight version tool.

1. **Simulate/Confirm Installation Configuration**:

    The default is "lightest installation" (without additional features). If users need specific features (such as Flow, DFU, backlight control), they can specify codes via the `--features` parameter (for example `2 5 6`).

    

    Execute simulation to confirm installation path and source:

    ```bash

    ./scripts/install_logi_plus_mini.sh --dry-run

    ```



2. **Execute Installation**:
    Inform the user of the current feature selection and ask if they want to proceed with installation. If agreed:
    ```bash
    ./scripts/install_logi_plus_mini.sh
    ```

### Feature Code Reference Table

When users ask about the meaning of each option, refer to the table below:

| Code | Name | Description | Recommendation |
| :--- | :--- | :--- | :--- |
| **1** | analytics | Send usage data and diagnostics to Logitech. | Recommend disabling |
| **2** | flow | Cross-computer control and file transfer (Logi Flow). | Enable as needed |
| **3** | sso | Account login functionality (cloud backup of settings). | Recommend disabling |
| **4** | update | Automatic software updates. | **Strongly recommend disabling** (avoid bloated components returning after updates) |
| **5** | dfu | Device firmware updates. | **Recommend enabling** |
| **6** | backlight | Keyboard backlight adjustment and customization. | Enable as needed (MX Keys, etc.) |
| **7** | logivoice | Logitech voice dictation and translation features. | Recommend disabling |
| **8** | aiprompt | AI Prompt Builder (ChatGPT shortcut). | Recommend disabling |
| **9** | recommend | Device recommendation advertisements. | Recommend disabling |
| **10** | smartactions | Smart actions (macros/automation workflows). | Enable as needed |
| **11** | ring | Actions Ring screen circular menu. | Recommend disabling |
| **12** | all | Install all features above. | Not recommended |

**Common Recommended Combinations:**
- **Standard Practical (2 5 6)**: Flow + Firmware Updates + Backlight Control.
- **Ultra Minimal Stable (5)**: Firmware updates only, everything else disabled.
- **Absolute Lightweight (Enter)**: No codes selected, driver core only.

## Troubleshooting

- **Permission Error**: Ensure scripts have execute permission (`chmod +x scripts/*.sh`).
- **Sudo Timeout**: Scripts have built-in `sudo -v` warmup. If execution takes too long, you may need to enter the password again.
- **Installation Failure**: If `install_logi_plus_mini.sh` fails during the automated input phase (due to upstream changes in Q&A order), consider manually guiding users to run the tool instead.
