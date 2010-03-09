From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: bf5xx-sport: use common SPORT code
 for MMR info
Date: Tue, 09 Mar 2010 20:50:34 +0000
Message-ID: <1268167834.3720.78.camel@odin>
References: <1268157494-13447-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id DE6E2244EA
	for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2010 21:50:31 +0100 (CET)
Received: by mail-bw0-f220.google.com with SMTP id 20so6563086bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 09 Mar 2010 12:50:31 -0800 (PST)
In-Reply-To: <1268157494-13447-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-03-09 at 12:58 -0500, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>
> 
> No point in duplicating this structure layout in each driver.
> 
> Signed-off-by: Barry Song <barry.song@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
