From: dlbarron@nc.rr.com
Subject: Problems with snd-intel8x0
Date: Thu, 08 Apr 2004 15:50:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <94de2d94ee62.94ee6294de2d@southeast.rr.com>
Reply-To: dlbarron@nc.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-language: en
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

First let me apologize if it is inappropriate to post this here.  I've been trying to get help on this problem on alsa-users and everyone on that list is as stumped as I am.
I have a home-bilt computer using an MSI 865PE Neo 2 motherboard.  I've booted with xnoppix and it detects the sound card as intel8x0, so that's what I'm trying to get going using alsa.  
I'm running LFS linux (www.linuxfromscratch.org) using kernel 2.4.25.  I tried OSS first, because of simplicity, and it works fine, so I know my hardware and permissions are correct.
So lately I've been trying to use alsa and I'm stuck.  I do not get any errors at all, in fact it looks like sound is working fine, but I never get a peep out of my speakers.
Let me also say, that I've gotten alsa working on my pc at work, using LFS linux, so I believe I know what I'm doing there.  Unfortunately that machine uses CS4236, instead of intel8x0.
What do I need to supply to help debug this problem?  I would assume you will need my modules.conf, but what else do you need to see?

I would really apprecieat any help at all.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
