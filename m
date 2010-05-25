From: Krzysztof Foltman <wdev@foltman.com>
Subject: Re: [PATCH 1/1] ALSA: usb-audio: add support for Akai
 MPD16
Date: Tue, 25 May 2010 10:07:18 +0100
Message-ID: <4BFB9346.4050701@foltman.com>
References: <1274299579-12990-1-git-send-email-wdev@foltman.com>	<4BF4E440.9030105@ladisch.de>	<4BF4E97A.9020209@foltman.com>
	<4BF4FF32.8080206@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound-mail-01.bluehost.com (cpoproxy1-pub.bluehost.com
	[69.89.21.11]) by alsa0.perex.cz (Postfix) with SMTP id 0DBA724368
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 11:06:35 +0200 (CEST)
In-Reply-To: <4BF4FF32.8080206@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 20/05/10 10:21, Clemens Ladisch wrote:

> The comments in this file are usually only about the protocol itself,
> because this is what the driver needs to know.

Okay. Any comments about the 20 May version of the patch? It has the 
output routine almost completely rewritten, and the comments are limited 
to essential stuff (anyone can now find the previous version with 
protocol description by googling mpd16 protocol, so it should be OK).

Thanks,
Krzysztof
