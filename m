From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: rx51: Add FM transmitter
	support
Date: Mon, 21 Feb 2011 18:44:54 +0000
Message-ID: <20110221184454.GB5192@opensource.wolfsonmicro.com>
References: <1298293042-13801-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 729F324490
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 19:44:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298293042-13801-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 21, 2011 at 02:57:22PM +0200, Jarkko Nikula wrote:
> Si4713 FM transmitter on Nokia RX-51/N900 is connected to same Line out
> signals of TLV320AIC34 than TPA6130 headphone amplifier.
> 
> This patch adds route to transmitter and "FM Transmitter" control to keep
> route active when needed.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
