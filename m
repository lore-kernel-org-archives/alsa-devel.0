From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb: Novation Twitch not working on Linux 4.7
Date: Wed, 21 Sep 2016 13:32:43 +0200
Message-ID: <aa460413-a017-cf4b-e35a-cfe3ed2eb890@ladisch.de>
References: <87intpbkkd.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id E25682606F7
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 13:32:44 +0200 (CEST)
In-Reply-To: <87intpbkkd.fsf@gnu.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?Q?Juan_Pedro_Bol=c3=advar_Puente?= <raskolnikov@gnu.org>, alsa-devel@alsa-project.org, Mark Hills <mark@xwax.org>
List-Id: alsa-devel@alsa-project.org

Juan Pedro Bol=EDvar Puente wrote:
>   $ aplay -D hw:Twitch -f S24_3LE -c 4 -r 44100 test.wav
>
>       Playing raw data 'prueba.wav' : Signed 24 bit Little Endian in 3byt=
es, Rate 44100 Hz, Channels 4
>       aplay: set_params:1361: Unable to install hw params:

Any error message in the system log?


Regards,
Clemens
