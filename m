From: Mike Oliphant <oliphant@mp3.com>
Subject: Rotating left/right to front/back
Date: Wed, 27 Feb 2002 16:58:23 -0800
Message-ID: <3C7D80AF.7040507@mp3.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am happily outputting sound via spdif on my YMF744B based soundcard 
(an AW744 Pro). What I'd like to be able to do, though is "rotate" the 
left/right channels to come out of front/back instead. The reason is to 
have stereo separation when I am at a different angle.

Is there any way to do this at the configuration level, or will I have 
to write software to split the PCM data into left/right and then output 
mono signals separately to front and back?

Any help would be much appreciated.

Thanks,

Mike

-- 
Mike Oliphant                                      oliphant@mp3.com
MP3.com - The Premier Music Service Provider       http://www.mp3.com



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
