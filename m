From: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: [linux-audio-user] RME Cardbus + multiface
Date: Mon, 19 Jan 2004 19:05:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040119190548.6a0f282f.TimBlechmann@gmx.net>
References: <20040112214015.40e73745.TimBlechmann@gmx.net>
	<NDBBLGIKBJENLAMOLFHGIEPHEHAB.mknecht@controlnet.com>
	<20040113000402.339967cb.TimBlechmann@gmx.net>
	<1074001565.556.1.camel@tpdrh.niptron.com>
	<20040113170943.3ca20073.TimBlechmann@gmx.net>
	<1074529472.524.5.camel@tpdrh.niptron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1074529472.524.5.camel@tpdrh.niptron.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Paul Davis <paul@linuxaudiosystems.com>, Thomas Charbonnel <thomas@undata.org>
List-Id: alsa-devel@alsa-project.org

hi all,

i just got an email from someone who experienced a problem similar to
mine:

> It sounds just like the problem I had. I even sent my laptop and card
> to Paul for toubleshooting. It turned out to be a problem with the
> firmware version. The card I had used a newer version.
i heard that you have to downdate the firmware in order to get the hdsp
working ... i did that (with the downdating software provided on rme's
homepage) ... maybe i missed something and i should try that, again ...

> The main cause of the distoriton was determined to be in the mixer
> section. I dont remember exactly what it was, but Paul might.
paul?

> Mine would work ok if I ran it with a sample rate of 32k. Maybe try
> that and see what happens. But eventually, I would guess the driver
> will need some updates to handle the situation.
i've don't know how to program a device driver ... but if someone could
tell me where the problem might come from, i could try to solve the
problems

cheers ...

 Tim                          mailto:TimBlechmann@gmx.de
                              ICQ: 96771783
--
The only people for me are the mad ones, the ones who are mad to live,
mad to talk, mad to be saved, desirous of everything at the same time,
the ones who never yawn or say a commonplace thing, but burn, burn,
burn, like fabulous yellow roman candles exploding like spiders across
the stars and in the middle you see the blue centerlight pop and
everybody goes "Awww!"
                                                          Jack Kerouac



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
