From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/2] ASoC: multi-comp: twl4030 updates
Date: Fri, 6 Aug 2010 15:43:36 +0300
Message-ID: <201008061543.36707.peter.ujfalusi@nokia.com>
References: <1281073795-4364-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100806121424.GH398@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id BF537103991
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 14:43:49 +0200 (CEST)
In-Reply-To: <20100806121424.GH398@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 06 August 2010 15:14:24 ext Mark Brown wrote:
> On Fri, Aug 06, 2010 at 08:49:53AM +0300, Peter Ujfalusi wrote:
> > The following two patch is for the current multi-comp
> > branch with twl4030 related fixes.
> =

> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> =

> though patch 2 could've used a better changelog!

Oops. The commit message in  patch 2 not even close to informative :(
I did however detailed the changes in the intro mail. These patches will be =

not visible at the end, since Liam will squash the changes to the multi-com=
p =

patch-set, and I did not wanted to put more effort on the commit message fo=
r =

the individual patches (I'm lazy, yes).
Just wanted to give Liam a hand with the twl4030 codec, and make sure that =
it =

is going to work flawlessly with multi-comp.

Never the less, I'll try to put more effort next time, since the commit mes=
sage =

on top of the patch is easier to read, than a separate mail.

Thanks,
P=E9ter
