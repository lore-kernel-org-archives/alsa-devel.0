From: tdavis@dsl-only.net
Subject: Re: trying to get sound working at a mac book
	pro	(core 2 duo)
Date: Thu, 15 Feb 2007 12:58:25 -0800
Message-ID: <20070215125825.xc06p28ap3vo40wo@webmail.dsl-only.net>
References: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
	<1171482019.7083.8.camel@razman.gruemaster.com>
	<564d96fb0702141209g6b032115pebe2ce1a7e3de57b@mail.gmail.com>
	<564d96fb0702141235p4ed263fdnb14de941be27e334@mail.gmail.com>
	<564d96fb0702141256t55f2febbna1e9bbdf50c200d@mail.gmail.com>
	<s5hire4l6ho.wl%tiwai@suse.de>
	<1171502000.7083.23.camel@razman.gruemaster.com>
	<s5hsld7aack.wl%tiwai@suse.de>
	<564d96fb0702151155q8d568ebj91ad7488faf1be6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 353F9314
	for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2007 21:58:31 +0100 (MET)
In-Reply-To: <564d96fb0702151155q8d568ebj91ad7488faf1be6a@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Rafael =?iso-8859-1?b?RXNw7W5kb2xh?= <rafael.espindola@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Rafael Esp=EDndola <rafael.espindola@gmail.com>:

>> As I mentioned in another mail, so far, it'd be much easier to check
>> the codec SSID in each patch code rather than changing the common PCI
>> quirk lookup.
>>
>> An experimental patch is below.  Rafael, please give it a try.
>
> It works. I have to do more tweaking on the macbook_pro_pin_configs,
> but this patch is a nice improvement.
>
>>
>> Takashi
>
> Thanks,
> Rafael



You can get documentation on your codec here:   =

http://www.idt.com/?app=3Dsearch&searchType=3Ddocument&categoryID=3D9452416

Tobin


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
