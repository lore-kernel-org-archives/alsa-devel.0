From: Frederique <auspicious@inventati.org>
Subject: Sound Blaster Z - Sound from front case port,
	but not back
Date: Tue, 16 Jan 2018 13:54:29 +0100
Message-ID: <1516107269.21264.1.camel@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from confino.investici.org (confino.investici.org [212.103.72.250])
 by alsa0.perex.cz (Postfix) with ESMTP id 757A9266E7C
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 13:54:32 +0100 (CET)
Received: from [212.103.72.250] (confino [212.103.72.250]) (Authenticated
 sender: auspicious@inventati.org) by localhost (Postfix) with ESMTPSA id
 509D7625DE
 for <alsa-devel@alsa-project.org>; Tue, 16 Jan 2018 12:54:30 +0000 (UTC)
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

I am using a Sound Blaster Z on Debian. The back microphone port works
as expected.

I can only manage to get audio out of the card by connecting the case
audio header to the sound card, and then using the case front audio
port and having the headphone port option enabled in alsamixer.

It is an inconvenience as now I have to use an extension cable to route
 things around (microphone cable at the back, audio cable to the
front), having a headset.

Does anyone know a solution to this? How hard can it be to make the
back audio part do the same thing as the front audio port?
