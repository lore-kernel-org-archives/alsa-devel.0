From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: What does fifo_size mean in struct
	snd_pcm_hardware?
Date: Tue, 11 Mar 2008 08:36:46 +0100
Message-ID: <47D6368E.6000007@ladisch.de>
References: <280b69ac0803101719w1c09b350hea532394471688e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 63D9124672
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 08:35:17 +0100 (CET)
In-Reply-To: <280b69ac0803101719w1c09b350hea532394471688e5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jin-Young Park <parkjy@mtekvision.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jin-Young Park wrote:
> Struct snd_pcm_hardware have fifo_size field.
> What does it meaning?

Nothing.  It isn't used.  Ignore it.


HTH
Clemens
