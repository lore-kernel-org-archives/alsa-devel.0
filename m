From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Drop 2.2/2.4 kernel support in alsa-driver build?
Date: Tue, 12 Jul 2011 22:48:03 +0200
Message-ID: <799b171c-0cc4-4501-a32b-e68b3d2b8007@email.android.com>
References: <s5hipr7h401.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 14648243A9
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 22:48:13 +0200 (CEST)
In-Reply-To: <s5hipr7h401.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>in upcoming 3.0-kernel era, I believe it's high time to drop the
>support of old 2.2/2.4 kernels in alsa-driver external builds.
>Is there any active user of such kernels with the latest alsa-driver?

When I was still testing such older kernels, I regularly
found compatibility bugs. So I guess the current alsa-driver
would not work anyway.


Regards,
Clemens
