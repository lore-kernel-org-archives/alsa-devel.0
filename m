From: Tobin Davis <tdavis@dsl-only.net>
Subject: Sound card question.
Date: Fri, 04 Apr 2008 10:38:27 -0700
Message-ID: <1207330707.1496.199.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EC2024617
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Apr 2008 19:38:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Are there any alsa supported sound cards that do hardware audio decoding
for MP3/WMA and otehr formats?  I'd like to look at the mechanism used
to connect the cards to the data stream.

Also, is there any block diagrams I can look at for the AOA and SOC
drivers?  Particularly the I2S bus support.

I'm ramping up support for a new project that will be Alsa based, and
would like to combine it with already established APIs if possible.

-- 
Tobin Davis 


The relative importance of files depends on their cost in terms of the
human effort needed to regenerate them.
		-- T.A. Dolotta
