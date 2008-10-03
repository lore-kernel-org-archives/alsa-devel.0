From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
 and ARM9 atmel boards.
Date: Fri, 03 Oct 2008 17:12:26 +0200
Message-ID: <48E6365A.6060803@atmel.com>
References: <48E47D42.8080306@atmel.com>	<20081002150731.GH2848@sirena.org.uk>	<48E4F025.80907@atmel.com>	<20081002181211.GA3345@sirena.org.uk>	<48E613BB.6090003@atmel.com>	<20081003131411.GC26035@sirena.org.uk>	<48E62A89.8070803@atmel.com>	<20081003143523.GE26035@sirena.org.uk>	<20081003164901.7ebddcd9@hskinnemo-gx745.norway.atmel.com>	<48E63158.9020708@atmel.com>
	<20081003170613.65c5ffd3@hskinnemo-gx745.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FF9A24333
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 17:12:36 +0200 (CEST)
In-Reply-To: <20081003170613.65c5ffd3@hskinnemo-gx745.norway.atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>, Mark Brown <broonie@sirena.org.uk>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

Haavard Skinnemoen a =E9crit :
> Sedji Gaouaou <sedji.gaouaou@atmel.com> wrote:
>> This will be my next task I think, I will try to move the at73c213 =

>> driver, but I wanted to have a clean ssc dai first.
> =

> That would be great!
> =

> Btw, where is the patch you want me to test? Should I apply all the
> three patches you sent me earlier, or is there a newer version
> somewhere?
> =

> Haavard
> =

I have just sent a new version in a set of 7 patches.
But you will still need to apply the patch where I removed all at32 and =

at91 directories([alsa-devel] [PATCH]ASoC: Remove at91 and at32 =

directories).
