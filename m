From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Blackfin AC97: fix build error after
 multi-component update
Date: Thu, 13 Jan 2011 14:16:18 +0000
Message-ID: <20110113141618.GF11840@opensource.wolfsonmicro.com>
References: <1294793853-16049-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B84F4103965
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 15:16:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294793853-16049-1-git-send-email-vapier@gentoo.org>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 07:57:33PM -0500, Mike Frysinger wrote:
> We need to tweak how we query the active capture/playback state after
> the recent overhauls of common code.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied, thanks.
