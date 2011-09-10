From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: problem with RME DSP MADI,
	kernel 2.6.38 and	hdspmixer from git
Date: Sat, 10 Sep 2011 11:08:35 +0200
Message-ID: <20110910090835.GY9510@ltw.loris.tv>
References: <59A59943-F67D-4ACD-94E5-95987CC46796@resorama.com>
	<20110908150911.GU9510@ltw.loris.tv>
	<0A02B5E2-4D1B-4445-B9F2-B4876CC8EEB2@resorama.com>
	<3BBC0003-F165-4994-8950-CC7CF24FDD6C@resorama.com>
	<4E6A8440.9090000@drcomp.erfurt.thur.de>
	<4E6B1B76.7010303@drcomp.erfurt.thur.de>
	<B4E35651-AB19-447A-9521-7894D05A2BB3@resorama.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id BE70A24469
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Sep 2011 11:08:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B4E35651-AB19-447A-9521-7894D05A2BB3@resorama.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maarten de Boer <maarten@resorama.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Natanael Olaiz <natanael.olaiz@immsound.com>, Pau Arumi <pau.arumi@immsound.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 10, 2011 at 10:52:44AM +0200, Maarten de Boer wrote:

> Hi Adrian,

Hi!

> Thanks for the reply.
> 
> > Forget all this, as I just learned, monitor out is 63/64
> Yes, I know this. But I find it confusing that, just by opening hdspmixer
> the first time after loading the snd-hdspm module

It's called a preset. Change it to your needs, make it the default and
it will load something different when you start hdspmixer.



Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver

Veni, Vidi, VISA... (ich kam, sah und kaufte)
