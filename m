From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Alsa-lib version info
Date: Wed, 14 Dec 2011 21:03:42 +0000
Message-ID: <201112142103.42310.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip06ir2.opaltelecom.net (out1.ip06ir2.opaltelecom.net
	[62.24.128.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A37F10384A
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 22:02:05 +0100 (CET)
Content-Disposition: inline
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

I have read in the docs about snd_asoundlib_version() to get a version string, 
but is there a way to get the SND_LIB_VERSION number from a runtime Alsa-lib, 
rather than from the header included at application build time, or would it 
have to be constructed from the string?

Thanks

Alan
