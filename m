From: =?iso-8859-1?Q?Carpon_fr=E9d=E9ric?= <frederic.carpon@yahoo.fr>
Subject: A minimal playback program does't work on my system
Date: Fri, 15 Aug 2014 18:19:43 +0100
Message-ID: <1408123183.97230.YahooMailNeo@web171303.mail.ir2.yahoo.com>
Reply-To: =?iso-8859-1?Q?Carpon_fr=E9d=E9ric?= <frederic.carpon@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm4-vm4.bullet.mail.ir2.yahoo.com
 (nm4-vm4.bullet.mail.ir2.yahoo.com [212.82.96.102])
 by alsa0.perex.cz (Postfix) with ESMTP id F063F264F0D
 for <alsa-devel@alsa-project.org>; Fri, 15 Aug 2014 19:19:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

Yesterday i have written.
I answer to everybody. I am new and I don't know if there is special rule.=
=A0
Note : It would be good to have a forum to see the messages and answers in =
a pretty form.=A0

the programme in c comes from=A0

http://equalarea.com/paul/alsa-audio.html
you can download it at
https://mon-partage.fr/f/uvyw39wo/

To answer to Michael i have sound in my HDMI with that :=A0
>speaker-test -c2 -D hw:0,0

so i did that=A0
>gcc=A0-o =A0 =A0minimal_playback =A0 =A0=A0minimal_playback.c =A0 =A0 -las=
ound (warning comes)
and
>./minimal_playback "plughw:0,0"
and i have this result :
>Error of segmentation

Where i can an exemple with the possibility to do something like that =A0:
>./minimal_playback =A0"plughw:0,0" =A0"mywave.wav"


Thank you for your help
