From: Susovan Ghosh <susovan@tataelxsi.co.in>
Subject: problem while reading the data from device(phone)
Date: Thu, 2 Aug 2007 09:20:15 +0530
Message-ID: <000001c7d4b8$3d3baae0$9529320a@telxsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tataelxsi.co.in (mail.tataelxsi.co.in [203.200.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id B1F131038F2
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 05:48:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Hi All,
       We are using ALSA for a application.We have a phone and RJ11 phone
adaptor-duel.I connect the phone to PC through the adaptor amd use the ALSA
function snd_pcm_readi() to capture what ever spoke in the phone.Adapter is
a USB device.we mention "plughw:0,0" as a capture device.When we run the
program we get an error "device is unavailable ".what may be the problem? or
de we required any thing more?

Thanx,
Susovan Ghosh
Engineer (D&D )
PRDE
Ph No:-998667320
Bangalore-560048
