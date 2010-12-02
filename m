From: Colin Kincaid Williams <discord@uw.edu>
Subject: Re: poor sound from ALC 850/880 in alsa 1.0.21 and
	1.0.23
Date: Thu, 2 Dec 2010 02:02:33 -0800
Message-ID: <AANLkTinveJNrLOZd+DMt-84vMvdQd4crGTbjE-OHXwGf@mail.gmail.com>
References: <AANLkTikE8tMisXQZfmKA_VqureL3iLU7gJhA4-L0p4HV@mail.gmail.com>
	<AANLkTikWLaEomZBVSd5iGo8D5rz51aFiA6waMw6JqpUh@mail.gmail.com>
	<AANLkTikvN5TqtB5RgXSd5A2FMDsDgD9ywo0P9-HJ=q9C@mail.gmail.com>
	<AANLkTikNgxUxicx31x_kD-Taj6+Hue_orb_vN67vbG8z@mail.gmail.com>
	<AANLkTi=GJgmYcDd-d6hqOW2uYwJ0i5KYOviv4Dx+JVg_@mail.gmail.com>
	<AANLkTi=Z1mzT70LSySZoY5W-j70p=AB=HJ5ezTYP=FLG@mail.gmail.com>
	<AANLkTimkqm5U=Zof48UuR7WR6cCOwaJ_9BLjKc=+iNyt@mail.gmail.com>
	<AANLkTimFdmXHazD2WEmbzFWmy84bgyAyAzcmAAFDQ6t9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C90A10382F
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 11:02:34 +0100 (CET)
Received: by bwz8 with SMTP id 8so7293765bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2010 02:02:34 -0800 (PST)
In-Reply-To: <AANLkTimFdmXHazD2WEmbzFWmy84bgyAyAzcmAAFDQ6t9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

muting switches val[2] and val[3] have no impact on the sound, it's
still poor sound quality, there must be something else wrong....


On Wed, Dec 1, 2010 at 7:59 PM, Raymond Yau <superquad.vortex2@gmail.com> w=
rote:
> 2010/12/1 Colin Kincaid Williams <discord@uw.edu>
>
>> I selected node 0x0c in =A0hdaanalyzer and see audio mixer [OxOb] in the
>> Connection list, but I cannot select the radio button.
>>
>
>
> Refer to your screen shot =A0, the mute switches of node 0x0b seem to be
> val[2] and val[3] of =A0the input amplifier
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
