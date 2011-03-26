From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: ad193x: tweak style to match other
 codecs
Date: Sat, 26 Mar 2011 14:12:46 +0000
Message-ID: <1301148766.3455.50.camel@odin>
References: <1301125940-5693-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 47AF224476
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 15:12:52 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id 26so1312226wwf.20
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 07:12:52 -0700 (PDT)
In-Reply-To: <1301125940-5693-1-git-send-email-vapier@gentoo.org>
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
Cc: Scott Jiang <scott.jiang@analog.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2011-03-26 at 03:52 -0400, Mike Frysinger wrote:
> From: Scott Jiang <scott.jiang@analog.com>
> 
> Rename the snd_soc_control_type field from "bus_type" to "control_type",
> and drop the now unused "control_data" field.
> 
> Signed-off-by: Scott Jiang <scott.jiang@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
