From: Marcus Andersson <054185595@telia.com>
Subject: Re: ALSA Hammerfall DSP driver
Date: Wed, 22 May 2002 19:15:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CEBD23F.AA8817D2@telia.com>
References: <200205140133.g4E1XWJ32168@op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailf.telia.com (mailf.telia.com [194.22.194.25])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA29017
	for <alsa-devel@alsa-project.org>; Wed, 22 May 2002 19:11:14 +0200
Received: from d1o67.telia.com (d1o67.telia.com [62.20.136.241])
	by mailf.telia.com (8.11.6/8.11.6) with ESMTP id g4MHB7j01824
	for <alsa-devel@alsa-project.org>; Wed, 22 May 2002 19:11:07 +0200 (CEST)
Received: from telia.com (maran@t7o67p30.telia.com [213.65.43.30])
	by d1o67.telia.com (8.8.8/8.8.5) with ESMTP id TAA27106
	for <alsa-devel@alsa-project.org>; Wed, 22 May 2002 19:11:06 +0200 (CEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> I am sure there will be minor glitches along the way. I would really
> appreciate feedback from anyone with an H-DSP (marcus - that means
> you! :)

Everything looks good, I just can't get it to play anything for me.
Probably due to my limited ALSA knowledge.

I have Ardour up and running with the hdsp driver and it lets me choose
between 18 output channels. I choose 'out1' and 'out2' and start
playback. I have set the volume on 'Chn',1 and 'Chn',2 with amixer;
'amixer Chn,1 65535' 'amixer Chn,2 65535'. No sound. What am I missing?

Input is working just fine.

Marcus

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
