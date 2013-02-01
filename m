From: =?ISO-8859-15?Q?R=FCdi?= <ruedi@battle-eggs.de>
Subject: New one on board - a damn rooky :">
Date: Fri, 01 Feb 2013 15:40:36 +0100
Message-ID: <510BD3E4.2050808@battle-eggs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 81D5026522D
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2013 15:40:37 +0100 (CET)
Received: from [192.168.71.158] (77-21-33-21-dynip.superkabel.de [77.21.33.21])
 by smtp.strato.de (jored mo12) (RZmta 31.14 DYNA|AUTH)
 with ESMTPA id N028b6p11EW83H for <alsa-devel@alsa-project.org>;
 Fri, 1 Feb 2013 15:40:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello @ all,

I'm R=FCdiger from Germany. I'm no programmer, that's my biggest fault =

here. But because of a "private" problem with ALSA and Intel HDA I want =

to help whereever I can - at least with that special problem.

I'm running a Lenovo ThinkCentre A58 with a ALC662 rev. 1 chip on board. =

The mainboard has 3 jacks at the back of the PC and 2 ones at it's front =

(mic and headphones).

The problem is, that the connectors are not automatically arranged to =

playback 5.1 surround sound. I must manually set the "model" to =

"asusmode4" to get 5.1 and then run a script as root, to set the =

backside jacks to output and to Center/LFE and rear speaker. Also I have =

to mute the internal speaker.

I've tried to patch the module manually, but this went wrong somehow. I =

don't know how to proceed.

So maybe you can help me and I can help you to complete the ALSA code =

for this special mainboard/PC - hopefully.

So long, I would thank you for your feedback.

Regards,
R=FCdiger
