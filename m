From: Daniel Mack <zonque@gmail.com>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Tue, 24 May 2011 12:47:31 +0200
Message-ID: <BANLkTinU=fS-_KLWy_gyio-HScEyWuDiKw@mail.gmail.com>
References: <4DD3E39D.30100@showlabor.de>
	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
	<4DD413FC.2090808@showlabor.de>
	<BANLkTi=2NeMGL6n7B0n-2p9La=45pM7ZHg@mail.gmail.com>
	<s5hhb8r1c20.wl%tiwai@suse.de> <4DD4BC97.5090702@showlabor.de>
	<s5h39kb17bv.wl%tiwai@suse.de> <4DD4D162.20608@showlabor.de>
	<BANLkTi=6CHJyFxvk9eVA430uhiwJ7f86vA@mail.gmail.com>
	<BANLkTi=OsrZKq3ZmC5cdFfuWb7qSOkPitw@mail.gmail.com>
	<4DD51E38.7090406@showlabor.de>
	<BANLkTiksJbpMr61QOfJ26iVhETDhSBDRFA@mail.gmail.com>
	<4DD63E8F.2030306@showlabor.de> <4DD64D13.9070200@showlabor.de>
	<BANLkTik-_m-Anr2s5=+G7ksyCHdOEGfN2w@mail.gmail.com>
	<BANLkTik9LLnvZRXE=8LW2UOrOOVCjp+kDg@mail.gmail.com>
	<4DDB8444.4010500@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D7940103871
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 12:47:32 +0200 (CEST)
Received: by pzk26 with SMTP id 26so3421060pzk.38
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 03:47:31 -0700 (PDT)
In-Reply-To: <4DDB8444.4010500@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 24, 2011 at 12:11 PM, Felix Homann <linuxaudio@showlabor.de> wrote:
> Hi again,
>
> Am 20.05.2011 17:08, schrieb Grant Diffey:
>>
>> I think there's something whacky with the control map. (I can't seem to
>> send
>> Ain5 to out 1 and 2 successfully. but I'll test this with felix's original
>> code.
>
> Grant, could you please try the attached patch. I haven't tested all 128
> controls but it seems to work fine here. And while you're at it, could you
> please try some other "outs" as well. My FTU is in a rack and I can't easily
> access out 5-8.

Good. I already amended and split the patch into pieces and can send
out the whole thing once you give me a go.

Daniel
