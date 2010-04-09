From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] WM8750: Convert to new API
Date: Fri, 09 Apr 2010 12:50:15 +0100
Message-ID: <1270813815.4618.0.camel@odin>
References: <1270752531-6016-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DBC11037EA
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Apr 2010 13:50:24 +0200 (CEST)
Received: by gyd10 with SMTP id 10so1579312gyd.38
	for <alsa-devel@alsa-project.org>; Fri, 09 Apr 2010 04:50:24 -0700 (PDT)
In-Reply-To: <1270752531-6016-1-git-send-email-marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-04-08 at 20:48 +0200, Marek Vasut wrote:
> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.
> 
> Also, this patch fixes the Jive and Spitz machine.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
