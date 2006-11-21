From: Pieter Palmers <pieterp@joow.be>
Subject: Re: Terratec Phase 88 Rack FW
Date: Tue, 21 Nov 2006 14:21:41 +0100
Message-ID: <4562FD65.8060007@joow.be>
References: <200611211330.04086.marioluca@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200611211330.04086.marioluca@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: marioluca@gmail.com
Cc: Alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

marioluca@gmail.com wrote:

>Hi all,
>
>i would like to know if the terratec phase 88 Rack fw is actually supported (maybe partially) or not.
>I've ordered one and would like to use it with jack for multitrack recording.
>
>If it is not supported yet i'm also interested in helping the development being guided by alsa developers to adapt the
>support for the existing phase 88 driver to use the new firewire model (there is someone that knows if it is possible [i.e. 
>if the phase88 FW Rack has the same chip of the PCI version ] or there is a need to develop a driver from scratch? )
>  
>
The terratec phase 88 is supported by the freebob project 
(freebob.sourceforge.net). Currently this support is established through 
jackd, there is some very basic ALSA support, but not really usefull. 
The jackd support already get's you a long way.

Pieter


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
