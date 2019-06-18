From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Add missing newline at end of file
Date: Tue, 18 Jun 2019 08:10:23 -0600
Message-ID: <20190618141023.GA20154@bogus>
References: <20190617143322.4332-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190617143322.4332-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, openbmc@lists.ozlabs.org, openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Jun 2019 16:33:22 +0200, Geert Uytterhoeven wrote:
> "git diff" says:
> 
>     \ No newline at end of file
> 
> after modifying the files.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt      | 2 +-
>  .../devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt     | 2 +-
>  Documentation/devicetree/bindings/regulator/pv88060.txt         | 2 +-
>  Documentation/devicetree/bindings/sound/cs42l73.txt             | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Rob
