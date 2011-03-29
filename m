From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: Blackfin: drop "-codec" from
	codec names
Date: Tue, 29 Mar 2011 21:30:35 +0100
Message-ID: <1301430635.3402.8.camel@odin>
References: <1301291110-2443-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E346103991
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 22:30:39 +0200 (CEST)
Received: by wwf26 with SMTP id 26so527920wwf.20
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2011 13:30:39 -0700 (PDT)
In-Reply-To: <1301291110-2443-1-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-03-28 at 01:45 -0400, Mike Frysinger wrote:
> The recent multi-component patch incorrectly added "-codec" suffixes to
> parts which are not MFD.  Drop the suffix from the machine drivers too.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

All

Acked-by: Liam Girdwood <lrg@ti.com>
