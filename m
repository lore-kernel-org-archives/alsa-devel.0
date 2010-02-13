From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: Make pmdown_time runtime
	configurable
Date: Sat, 13 Feb 2010 16:46:57 +0200
Message-ID: <6ed0b2681002130646w4b0b7049y3e5b9fb7c7fd8edd@mail.gmail.com>
References: <1265974819-25151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1265974819-25151-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f224.google.com (mail-fx0-f224.google.com
	[209.85.220.224])
	by alsa0.perex.cz (Postfix) with ESMTP id C1A90246D5
	for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2010 15:46:58 +0100 (CET)
Received: by fxm24 with SMTP id 24so1126831fxm.20
	for <alsa-devel@alsa-project.org>; Sat, 13 Feb 2010 06:46:57 -0800 (PST)
In-Reply-To: <1265974819-25151-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 12, 2010 at 1:40 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Provide a sysfs file allowing userspace to inspect and change the
> pmdown_time setting at runtime.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks for doing this,
Tested-by: Grazvydas Ignotas <notasas@gmail.com>
