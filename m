From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb midi devices.
Date: Thu, 18 Dec 2003 06:36:27 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE0CC5B.9030201@boosthardware.com>
References: <Pine.HPX.4.33n.0312171510340.4515-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Martin Langer wrote:
> 
>>And there are some other cards (Sonica, ...) which need a firmware download,
>>but there's no linux loader available.
> 
> 
> MobilePre, Sonica, Transit, Ozone (all from M-Audio).
> 

Thanks.

> 
> BTW:  Patrick, what would be the preferred format for submitting
> changed to the soundcard list?  (There's no file to send a patch for.)
> 

For now just make additions to each manufacturer. I am working on a more 
simple backend but haven't finished it yet.

ATM I have just split each manufacturer into their own file and parse it 
when the user asks to see it.

-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================


  Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
