From: Felix Homann <linuxaudio@showlabor.de>
Subject: How to bisect Alsa?
Date: Mon, 18 Apr 2011 11:06:35 +0200
Message-ID: <4DABFF1B.5090509@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A4CF1037F2
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 11:06:38 +0200 (CEST)
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

Hi,

I'd like to identify the cause of the MIDI USB issue mentioned in 
another message on the list. But I'm a little puzzled how to use 'git 
bisect' since there's the git tree for alsa-driver and another one for 
alsa-kernel. Where and how should I start?

Regards,

Felix
