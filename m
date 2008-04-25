From: Kristoffer Janke <kj@conceptT.com>
Subject: No sound/mixer with new laptops on board sound -
	hda_intel ALC883
Date: Fri, 25 Apr 2008 17:30:29 +0200
Message-ID: <4811F915.60208@conceptT.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.conceptT.com (unknown [84.200.19.22])
	by alsa0.perex.cz (Postfix) with ESMTP id E8F17247A4
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 17:32:12 +0200 (CEST)
Received: from [192.168.1.210] (dslb-088-076-062-032.pools.arcor-ip.net
	[88.76.62.32])
	by mail.conceptT.com (Postfix) with ESMTP id 4956C642E2F
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Apr 2008 17:32:12 +0200 (CEST)
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

Hello list,
I have a newer Medion Akoya MD 96420 Laptop (Mitac 8227D Barebone). The 
card is an Intel HDA compatible device, the codec is ALC883. There is no 
suitable model for the alc883 codec, tested all - no sound. So I think 
there is some work needed, I have not much knowledge in this area but 
would like to help if possible.
Alsa-info.sh output with newest(hg 6120) alsa driver: 
http://pastebin.ca/997178

--
Kristoffer Janke
