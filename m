From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 11/18] input: Add initial support for
	TWL6040 vibrator
Date: Thu, 16 Jun 2011 17:06:00 +0300
Message-ID: <4306005.scnJ1lQX4P@barack>
References: <1307706876-4768-1-git-send-email-peter.ujfalusi@ti.com>
	<5476342.2jZLF0UGcI@barack> <20110616120244.GA2611@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A3F152417E
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 15:01:57 +0200 (CEST)
In-Reply-To: <20110616120244.GA2611@htj.dyndns.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tejun Heo <tj@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hello,

On Thursday 16 June 2011 14:02:44 Tejun Heo wrote:
> > I'll move to create_workqueue.
> =

> I suppose you meant alloc_workqueue()? :)

Oh, yes. I mean that.
 =

> Sorry about the confusing names, I'm still in the (slow) process of
> deprecating older APIs.

Will do this soon, and I ping the other maintainers, if they see other issu=
es =

with the series, so I can make the change at the same time.

Thanks,
P=E9ter
