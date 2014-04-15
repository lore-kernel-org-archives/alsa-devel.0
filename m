From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Date: Tue, 15 Apr 2014 10:28:47 +0800
Message-ID: <20140415022846.GD7197@MrMyself>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
 <d09da3eb629143abd3f61ae037af4ddaf7286a83.1396432924.git.Guangyu.Chen@freescale.com>
 <20140414203851.GD25182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140414203851.GD25182@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: shawn.guo@linaro.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 14, 2014 at 09:38:51PM +0100, Mark Brown wrote:
> On Wed, Apr 02, 2014 at 06:10:20PM +0800, Nicolin Chen wrote:
> > Since we added fours clock to the DT binding, we should update the current
> > SAI dts/dtsi so as not to break their functions.
> 
> This doesn't apply against v3.15-rc1, can you please check and resend?

Please disregard this patch, since my v6 patch was compatible with the old
binding, the patch here is provisionally useless and I can later send it
via Shawn's tree.

Thank you,
Nicolin

