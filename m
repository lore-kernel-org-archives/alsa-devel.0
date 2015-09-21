From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [alsa-devel] System with multiple arizona (wm5102) codecs
Date: Mon, 21 Sep 2015 14:36:55 +0200
Message-ID: <20150921123655.GD16589@amd>
References: <20150914115439.GA29646@amd>
 <20150914115255.GE11200@ck-lbox>
 <20150915061832.GA25442@amd>
 <20150915080648.GG11200@ck-lbox>
 <20150915083552.GA14780@amd>
 <CAG5mAdybV2U5Z9FRPy4zVF10Ws63rybSHCMCEpKQ1ArTBLnXpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG5mAdybV2U5Z9FRPy4zVF10Ws63rybSHCMCEpKQ1ArTBLnXpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Crome <caleb@crome.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

>    I'd love to see the patches :-)  I've been trying to figure out the
> *right* way to add multiple codecs to a single card (and single CPU
> DAI) for some days now.  Any help would be greatly appreciated.

I eventually got it to work, but I'm really sure that what I've done
can't be considered "right" :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
