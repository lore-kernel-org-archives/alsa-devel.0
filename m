From: VDR User <user.vdr@gmail.com>
Subject: Re: Problems with snd-hda-intel and Asus M2NPV-VM.
	Please help!
Date: Mon, 6 Jul 2009 08:44:08 -0700
Message-ID: <a3ef07920907060844o50d8be15s16bc1bca8acf72b6@mail.gmail.com>
References: <a3ef07920906241108u786a6c89j80f2ad89eebf7dcd@mail.gmail.com>
	<a3ef07920906241134m2f84ac06pef7465ce356f893f@mail.gmail.com>
	<s5hvdmfv6s6.wl%tiwai@suse.de>
	<a3ef07920906291028q670ed146t1451650d0c2a4713@mail.gmail.com>
	<s5hzlbq83o8.wl%tiwai@suse.de>
	<a3ef07920906301030p7f84d4c4xe6c0590f436b4de9@mail.gmail.com>
	<s5heit1bjki.wl%tiwai@suse.de>
	<a3ef07920907010726o6e06dd8dn25b33d4ee5b6c42c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f189.google.com (mail-vw0-f189.google.com
	[209.85.212.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 59C7524621
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 17:44:10 +0200 (CEST)
Received: by vwj27 with SMTP id 27so2885777vwj.16
	for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2009 08:44:08 -0700 (PDT)
In-Reply-To: <a3ef07920907010726o6e06dd8dn25b33d4ee5b6c42c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 1, 2009 at 7:26 AM, VDR User<user.vdr@gmail.com> wrote:
> On Tue, Jun 30, 2009 at 12:36 PM, Takashi Iwai<tiwai@suse.de> wrote:
>>> =A0Is it possible the revision of the MCP51 I have is not
>>> supported (yet)? =A0Please let me know anything further I can do to help
>>> figure this out.
>>
>> Well, the question is rather how the hardware is implemented.
>> The SPDIF and HDMI implementation depends pretty much on the hardware.
>> For example, HDMI has to be activated by a video driver (e.g. X) even
>> for the audio transfer.
>>
>> So, if the codec registers look good, I can't say more than that.
>> Only hardware vendors could advise...
>
> My mainboard doesn't have HDMI out but it did come with an HDTV module
> for HDTV output, could it still be that something in my xorg.conf is
> missing that is causing this not to work? =A0How can I tell (or could
> you tell by my logs) if the codec registers are good? =A0I'm not sure
> how to proceed from here aside of buying a new mainboard.

Anyone?  Any suggestions at all?
