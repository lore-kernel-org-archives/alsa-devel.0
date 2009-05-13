From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: asoundconf removed from alsa-utils?
Date: Wed, 13 May 2009 11:12:04 -0400
Message-ID: <604760770905130812s36a5ab7em63d6627f70d69c66@mail.gmail.com>
References: <9203434.1242220124470.JavaMail.root@mswamui-andean.atl.sa.earthlink.net>
	<alpine.LNX.2.00.0905131527010.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.156])
	by alsa0.perex.cz (Postfix) with ESMTP id A1EBB24800
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 17:12:05 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so482194ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 08:12:04 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0905131527010.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 9:28 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> asoundconf is probably an Ubuntu specific tool. We do not maintain this
> utility. Ask on appropriate place.

Correct - asoundconf was developed for Debian and Ubuntu but has been
removed from Debian unstable's (and Ubuntu Karmic's) alsa-utils. There
are no plans to resurrect or maintain it beyond the existing support
life cycles of the stable releases.
