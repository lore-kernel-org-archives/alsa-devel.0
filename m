From: Bruce Paterson <bruce@tele-ip.com>
Subject: Re: Am I asking the right people ?
Date: Thu, 28 Nov 2002 13:00:01 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE578A1.8020600@tele-ip.com>
References: <20021127133237.71BFE33E8C@mail.tele-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>Am I sending these queries about the operation of alsa through the API 
>>to the right place ?  I'm trying to use alsa for a real scientific
>>application and I'm starting to worry it simply isn't ready yet.
> 
> 
> the API is ready. the documentation is not. some of us have been using
> ALSA to develop serious audio applications for several years. there
> are no substantive issues with the API at this time.

In that case it should be a simple issue with the way I'm using the API 
then. Since I can't reproduce the problem using aplay I've suspected 
this. I did send the main part of code loop earlier in the thread, but 
if you like I can send the whole application to you or to another 
willing API guru to just run and see if you get the same problem. 
Essentially it's a very basic alsa application.

> your question has nothing to do with the state of the API and
> everything to do with people's workloads and their interest in solving
> yet another common problem with audio software (the problem you're
> describing has happened to me often, and can be caused by several
> different things in your code).

I understand. I'm looking for any help I can get since I have already 
tried everything I can think of.
However, it is possible you will get many more annoying questions very 
like mine with the lack of documentation, especially with alsa now being 
included in the latest kernel.

> i would point out that "scrapping ALSA" would be pretty stupid when
> its the standard audio API in the 2.5/2.6 kernel.

ooh no scrapping means far worse than that! It means Windoze.....
(OSS can't do what we need anyway.)

-- 
Cheers,
Bruce
-------------------------------------------------------------------
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager.

     /\\\/\\\/\\\    /   /      Bruce Paterson
    /  \\\ \\\ \\\  /   /    Senior Design Engineer
   /   /\\\/\\\/\\\/   /   87 Peters Ave, Mulgrave, Vic, 3170
  /   /  \\\ \\\ \\\  /  PO Box 4112, Mulgrave, Vic, 3170, Australia
/   /    \\\/\\\ \\\/   Ph: +61 3 8561 4232   Fax: +61 3 9560 9055
       Tele-IP Ltd.      Email: bruce@tele-ip.com    Icq: #32015991
                         WWW:   http://www.tele-ip.com       VK3TJN
-------------------------------------------------------------------




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
