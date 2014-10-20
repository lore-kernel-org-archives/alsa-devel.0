From: rodney byne <rodney.byne@tiscali.co.uk>
Subject: [RFC PATCH] Inverted internal mic
Date: Mon, 20 Oct 2014 14:52:50 +0100
Message-ID: <1413813170.2451.0@rodney-AMILO-L-Series>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="Flowed"; DelSp="Yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out.ipsmtp3nec.opaltelecom.net (out.ipsmtp3nec.opaltelecom.net
 [62.24.202.75]) by alsa0.perex.cz (Postfix) with ESMTP id 58FF4261521
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 15:53:03 +0200 (CEST)
Content-Disposition: inline
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

Hello to David Henningsson and associates,

I have been trawling the internet to find out
why the internal mic on my Acer Aspire One AOA-110
netbook is permanently inhibited by Alsa.
This little pc runs Linux Peppermint 5 OS, which contains
PulseAudio ESD over-riding the Alsa sound architecture.

Thinking initially this was a "programming" fault, I
have read as much of the history up to the patch need as
I can understand and so appreciate this action on your
part was deliberate - but must comment nonetheless that
this matter is disconcerting from a casual user perspective.

In short, the owner just wants everything on his
machine to work normally and so I would really like to
use the internal mic function for what it was intended.

Personally I have often wondered why PA was ever introduced,
as Alsa & AlsaMixer are perfectly capable of working on
their own, as testament to early releases of Linux Mint.
My opinion is PA just makes the sound system too complicated.
I call it guilding the lilly - so use the principle K.I.S.S

My question therefore is, can the patch be easily lifted
at will to re-enable the internal microphone?

Thanks and best regards,
from Rodney.
